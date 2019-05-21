def qaav6(Rrs, wl, aw, bbw):
    # TODO: Comment steps 2 and onward

    """

    :param Rrs: Above surface remote sensing reflectance (sr^-1)
    :param wl: Corresponding Wavelengths (nm)
    :param aw: Pure water absorption coefficient
    :param bbw: Pure water backscattering coefficient
    :return: total absorption and backscattering coefficients

    """

    # Import Libraries
    import numpy as np
    import pandas as pd

    id443 = np.where(abs(wl - 443) == min(abs(wl - 443)))
    id490 = np.where(abs(wl - 490) == min(abs(wl - 490)))
    id555 = np.where(abs(wl - 550) == min(abs(wl - 550)))
    id670 = np.where(abs(wl - 670) == min(abs(wl - 670)))

    # Step 1: Compute ratio of backscattering coefficient to the sum of the absorption and
    # backscattering coefficients, bb/a+bb

    # Compute Subsurface remote sensing reflectance
    rrs = Rrs/(0.52 + 1.7 * Rrs)

    g0 = 0.089
    g1 = 0.125

    u = (-g0 + (g0 ** 2 + 4 * g1 * rrs) ** 0.5) / (2 * g1)

    # Step 2: Determine Reference Wavelength by Rrs value

    if Rrs[id670] < 0.0015:

        wl_ref = wl[id555]
        id_ref = id555

        rrs_ref = rrs[id_ref]
        ki = np.log10((rrs[id443] + rrs[id490]) / (rrs[id_ref] + 5 * rrs[id670] * rrs[id670] / rrs[id490]))
        a_ref = aw[id555] + 10 ** (-1.146 - 1.366 * ki - 0.469 * ki ** 2)

    else:

        wl_ref = 670
        id_ref = id670
        a_ref = aw[id670] + 0.39 * (rrs[id670] / (rrs[id443] + rrs[id490])) ** 1.14

    # Step 3: Compute Backscattering of Particles at the Reference Wavelength

    bbp_ref = u[id_ref] * a_ref/(1 - u[id_ref]) - bbw[id555]

    # Step 4
    Y = 2.0 * (1 - 1.2 * np.exp(-0.9 * rrs[id443] / rrs[id555]))

    # Step 5: Compute Total Absorption and Backscattering by Particles
    a = []
    bbp = []

    for i in range(len(wl)):
        bbp_temp = bbp_ref * (wl_ref / wl[i]) ** Y
        a_temp = (1 - u[i]) * (bbw[i] + bbp_temp) / u[i]

        bbp = np.append(bbp, bbp_temp)
        a = np.append(a, a_temp)

    # Step 6: Compute Total Backscattering Coefficient
    bb = bbw + bbp

    # Step 7: Put IOPs into DataFrame
    iop_df = pd.DataFrame(data={'a': a, 'bbp': bbp, 'bb': bb}, index=wl)

    return iop_df


