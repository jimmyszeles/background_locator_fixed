package yukams.app.background_locator_2.provider

import android.location.Location
import android.os.Build
import com.google.android.gms.location.LocationResult
import yukams.app.background_locator_2.Keys
import java.util.HashMap

class LocationParserUtil {
    companion object {
        fun getLocationMapFromLocation(location: Location): HashMap<String, Any>? {
            var speedAccuracy = 0f
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                speedAccuracy = location.speedAccuracyMetersPerSecond
            }
            var isMocked = false
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                isMocked = location.isFromMockProvider
            }

            return hashMapOf(
                    Keys.ARG_IS_MOCKED to isMocked as Any,
                    Keys.ARG_LATITUDE to location.latitude as Any,
                    Keys.ARG_LONGITUDE to location.longitude as Any,
                    Keys.ARG_ACCURACY to location.accuracy as Any,
                    Keys.ARG_ALTITUDE to location.altitude as Any,
                    Keys.ARG_SPEED to location.speed as Any,
                    Keys.ARG_SPEED_ACCURACY to speedAccuracy as Any,
                    Keys.ARG_HEADING to location.bearing as Any,
                    Keys.ARG_TIME to location.time.toDouble() as Any,
                    Keys.ARG_PROVIDER to location.provider as Any,
            )
        }

        fun getLocationMapFromLocation(location: LocationResult?): HashMap<String, Any>? {
            val firstLocation = location?.lastLocation ?: return null

            var speedAccuracy = 0f
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                speedAccuracy = firstLocation.speedAccuracyMetersPerSecond
            }
            var isMocked = false
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
                isMocked = firstLocation.isFromMockProvider
            }

            return hashMapOf(
                    Keys.ARG_IS_MOCKED to isMocked as Any,
                    Keys.ARG_LATITUDE to firstLocation.latitude as Any,
                    Keys.ARG_LONGITUDE to firstLocation.longitude as Any,
                    Keys.ARG_ACCURACY to firstLocation.accuracy as Any,
                    Keys.ARG_ALTITUDE to firstLocation.altitude as Any,
                    Keys.ARG_SPEED to firstLocation.speed as Any,
                    Keys.ARG_SPEED_ACCURACY to speedAccuracy as Any,
                    Keys.ARG_HEADING to firstLocation.bearing as Any,
                    Keys.ARG_TIME to firstLocation.time.toDouble() as Any,
                )
        }
    }
}