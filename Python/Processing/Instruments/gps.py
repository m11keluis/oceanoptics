def read_gps(gpx_path, filter = ""):

    """

    :param gpx_path:
    :param filter:
    :return:
    """

    # Import Packages
    import glob
    import gpxpy
    import os
    import pandas as pd

    # Run
    gpx_files = glob.glob(os.path.join(gpx_path, filter + "*.gpx"))
    run_data = []

    for file_idx, gpx_file in enumerate(gpx_files):
        gpx = gpxpy.parse(open(gpx_file, 'r'))

        # Loop through tracks
        for track_idx, track in enumerate(gpx.tracks):
            track_name = track.name
            track_time = track.get_time_bounds().start_time
            track_length = track.length_3d()
            track_duration = track.get_duration()
            track_speed = track.get_moving_data().max_speed

            for seg_idx, segment in enumerate(track.segments):
                segment_length = segment.length_3d()
                for point_idx, point in enumerate(segment.points):
                    run_data.append([file_idx, os.path.basename(gpx_file), track_idx, track_name,
                                     track_time, track_length, track_duration, track_speed,
                                     seg_idx, segment_length, point.time, point.latitude,
                                     point.longitude, point.elevation, segment.get_speed(point_idx)])

    df = pd.DataFrame(run_data, columns=['File_Index', 'File_Name', 'Index', 'Name',
                                    'Time', 'Length', 'Duration', 'Max_Speed',
                                    'Segment_Index', 'Segment_Length', 'Point_Time', 'Point_Latitude',
                                    'Point_Longitude', 'Point_Elevation', 'Point_Speed'])

    return df
