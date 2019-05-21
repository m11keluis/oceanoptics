""""
def read_gpx(gps_file):

    """

    :param gps_file: gpx file from GPS unit
    :return: pandas dataframe with gps coordinates by time, speed, and altitude
    """

    # Packages
    import gpxpy
    import pandas as pd

    gpx = gpxpy.parse(open(gps_file))
    track = gpx.tracks[0]
    segment = track.segments[0]

    data = []
    #for point_idx, point in enumerate(segment.points):
    #    data.append([point.longitude, point.latitude, point.elevation, point.time, segment.get_speed(point_idx)])


    columns = ['Longitude', 'Latitude', 'Altitude', 'Time', 'Speed']
    gps_df = pd.DataFrame(data, columns=columns)

    return gps_df

"""
