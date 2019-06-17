def L8Zsd(Rrs, wl):

    """

    :param Rrs: Remote sensing reflectance (sr^-1)
    :param wl: Wavelength (nm)
    :return:

    """

    # Import Libraries
    import numpy as np

    # Rrs to IOPs (

    # IOPs to Kd
    nw = bbw/bb

    kd = (1+0.005*sa)*a+(1-0.265*nw)*4.259*(1-0.52*np.exp(-10.8*a))*bb

    # Kd to Secchi Disk Depths

    [kdmin, index] = min(kd)

    kdminwl = wl[index]

    for secchi if wl is 530:
        if kdminwl == 530:
            zsd = 1. / (2.5 * kdmin) * np.log(abs(0.14 - max(Rrs)) / 0.013);
        else:
            zsd = 1. / (2.5 * kdmin) * np.log(abs(0.14 - Rrs[index]) / 0.013);

    return zsd