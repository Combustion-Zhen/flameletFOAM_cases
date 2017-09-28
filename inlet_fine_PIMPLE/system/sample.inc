    diam    0.0072;
    x02 #calc "$diam*2.0";
    x04 #calc "$diam*4.0";
    x05 #calc "$diam*5.0";
    x10 #calc "$diam*10.0";
    x15 #calc "$diam*15.0";

    interpolationScheme cell;

    xDPlane
    {
        type            plane;
        interpolate     true;
        normalVector    ( 1 0 0 );
    }

    surfaces
    (
        xD02
        {
            $xDPlane;
            basePoint   ( $x02 0 0 );
        }

        xD04
        {
            $xDPlane;
            basePoint   ( $x04 0 0 );
        }

        xD05
        {
            type        patch;
            patches     ( outlet );
            interpolate true;
            triangulate false;
        }
    );
