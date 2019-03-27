def read_sba(rrs_file):
    # TODO: Add in Tilt Correction

    """

    :param rrs_file: Satlantic L2s Matfile
    :return: Dataframe with Rrs indexed by timestamp and wavelength column headers
    """

    # Packages
    from scipy.io import loadmat
    import pandas as pd
    import datetime as dt

    # Load Matlab structure in Python
    rrs_mat = loadmat(rrs_file, struct_as_record=False, squeeze_me=True)['hdfdata']

    # Format Rrs Reads
    rrs_temp = rrs_mat.LS_hyperspectral_data / rrs_mat.ES_hyperspectral_data

    # Format Time Stamp
    time_stamp = [dt.datetime.strptime('{} {}'.format(d, t), '%Y%m%d %H%M%S%f')
                  for d, t in zip(rrs_mat.ES_hyperspectral_datetag, rrs_mat.ES_hyperspectral_timetag2)]

    # Format Wavelengths
    wl = list(map(float, rrs_mat.ES_hyperspectral_fields))

    # Format DataFrame
    rrs_df = pd.DataFrame(rrs_temp, index=time_stamp, columns=wl)

    return rrs_df
