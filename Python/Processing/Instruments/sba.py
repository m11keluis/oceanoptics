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
    rrs_df = pd.DataFrame(rrs_temp, columns=wl)
    rrs_df['dt_stamp'] = time_stamp

    return rrs_df


def stat_bin(df, num=10, method=1):
    # TODO: Comment Function

    """

    :param df: rrs dataframe from read_sba function
    :param num: number of rows to average over (Default is 10)
    :param method: 1) Mean 2) Median (Default is Mean)
    :return: dataframe with values averaged every 10 measurements
    """
    # Import Packages
    import pandas as pd
    import numpy as np

    resamp = df.groupby(np.arange(len(df)) // num)

    if method == 1:
        resampled_df = resamp.mean()
    else:
        resampled_df = resamp.median()

    grp_dt = df.dt_stamp.groupby(np.arange(len(df)) // 10)
    df_mean = []

    for key, item in grp_dt:
        temp = grp_dt.get_group(key).pipe(lambda d: (lambda m: m + (d - m).mean())(d.min())).to_pydatetime()
        df_mean.append(temp)

    resampled_df = resampled_df.set_index(pd.DatetimeIndex(pd.DataFrame(df_mean)))

    return resampled_df