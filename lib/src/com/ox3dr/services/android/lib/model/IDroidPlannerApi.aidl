// IDroidPlannerApi.aidl
package com.ox3dr.services.android.lib.model;

import com.ox3dr.services.android.lib.drone.property.Gps;
import com.ox3dr.services.android.lib.drone.property.Home;
import com.ox3dr.services.android.lib.drone.property.Speed;
import com.ox3dr.services.android.lib.drone.property.Attitude;
import com.ox3dr.services.android.lib.drone.property.Altitude;
import com.ox3dr.services.android.lib.drone.property.Battery;
import com.ox3dr.services.android.lib.drone.property.Parameters;
import com.ox3dr.services.android.lib.drone.mission.Mission;
import com.ox3dr.services.android.lib.drone.property.State;
import com.ox3dr.services.android.lib.drone.property.VehicleMode;
import com.ox3dr.services.android.lib.drone.property.Type;
import com.ox3dr.services.android.lib.coordinate.Point3D;
import com.ox3dr.services.android.lib.drone.property.Signal;
import com.ox3dr.services.android.lib.drone.property.GuidedState;
import com.ox3dr.services.android.lib.coordinate.LatLong;
import com.ox3dr.services.android.lib.gcs.follow.FollowState;
import com.ox3dr.services.android.lib.gcs.follow.FollowType;
import com.ox3dr.services.android.lib.drone.mission.item.MissionItem;
import com.ox3dr.services.android.lib.drone.mission.item.raw.MissionItemMessage;
import com.ox3dr.services.android.lib.drone.mission.item.complex.CameraDetail;
import com.ox3dr.services.android.lib.drone.mission.item.complex.Survey;
import com.ox3dr.services.android.lib.drone.mission.item.complex.StructureScanner;

/**
* Interface used to access the drone properties.
*/
interface IDroidPlannerApi {
    /**
        * Retrieves the gps property of the connected drone.
        */
        Gps getGps();

        /**
        * Retrieves the state property of the connected drone.
        */
        State getState();

        /**
        * Retrieves all the vehicle modes for the connected drone.
        */
        VehicleMode[] getAllVehicleModes();

        /**
        * Retrieves the parameters property of the connected drone.
        */
        Parameters getParameters();

        /**
        * Retrieves the speed property of the connected drone.
        */
        Speed getSpeed();

        /**
        * Retrieves the attitude property of the connected drone.
        */
        Attitude getAttitude();

        /**
        * Retrieves the home property of the connected drone.
        */
        Home getHome();

        /**
        * Retrieves the battery property of the connected drone.
        */
        Battery getBattery();

        /**
        * Retrieves the altitude property of the connected drone.
        */
        Altitude getAltitude();

        /**
        * Retrieves the mission property of the connected drone.
        */
        Mission getMission();

        /**
        * Retrieves the set of raw mission items.
        */
        MissionItemMessage[] getRawMissionItems();

        /**
        * Retrieves the signal level between the connected drone and the GCS.
        */
        Signal getSignal();

        /**
        * Retrieves the type property of the connected drone.
        */
        Type getType();

        /**
        * Checks if we have access to the connected drone.
        */
        boolean isConnected();

        /**
        * Retrieves the guided state of the connected drone.
        */
        GuidedState getGuidedState();

        /**
        * Retrieves the follow-me state of the connected drone.
        */
        FollowState getFollowState();

        /**
        * Return a list of support follow modes on the connected drone.
        */
        FollowType[] getFollowTypes();

        /**
        * Return the set of camera information available for the connected drone.
        */
        CameraDetail[] getCameraDetails();

        /**
        * Retrieves an updated copy of the passed survey.
        */
        Survey updateSurveyMissionItem(in Survey survey);

        StructureScanner updateStructureScanner(in StructureScanner item);

        /*** Oneway method calls ***/

        /**
        * Change the vehicle mode for the connected drone.
        * @param newMode new vehicle mode.
        */
        oneway void changeVehicleMode(in VehicleMode newMode);

        /**
        * Asynchronous call used to stop listening to updates for the drone instance whose id is
        * connected by 'droneId'.
        * If no other clients is listening to the drone instance, connection with the underlying
        * vehicle will be broken.
        */
        oneway void disconnectFromDrone();

        /**
        * Refresh the parameters for the connected drone.
        */
        oneway void refreshParameters();

        /**
        * Write the given parameters to the connected drone.
        */
        oneway void writeParameters(in Parameters parameters);

        /**
        * Update the mission property for the drone model in memory.
        * @param mission mission to upload to the drone.
        * @param pushToDrone if true, upload the mission to the connected device.
        */
        oneway void setMission(in Mission mission, boolean pushToDrone);

        /**
        * Update the mission items for the drone model in memory.
        * @param missionItems Set of missionItemMessage
        * @param pushToDrone if true, upload the mission to the connected device.
        */
        oneway void setRawMissionItems(in MissionItemMessage[] missionItems, boolean pushToDrone);

        /**
        * Create a dronie mission, and upload it to the connected drone.
        */
        oneway void generateDronie();

        /**
        * Arm or disarm the connected drone.
        * @param arm true to arm, false to disarm.
        */
        oneway void arm(boolean arm);

        /**
        * Start the magnetometer calibration process.
        * @param startPoints points to start the calibration with.
        */
        oneway void startMagnetometerCalibration(in List<Point3D> startPoints);

        /**
        * Stop the magnetometer calibration is one if running.
        */
        oneway void stopMagnetometerCalibration();

        /**
        * Start the imu calibration.
        */
        oneway void startIMUCalibration();

        /**
        * Send an imu calibration acknowledgement.
        */
        oneway void sendIMUCalibrationAck(int step);

        /**
        * Perform a guided take off.
        * @param altitude altitude in meters
        */
        oneway void doGuidedTakeoff(double altitude);

        /**
        * Send a guided point to the connected drone.
        * @param point guided point location
        * @param force true to enable guided mode is required.
        */
        oneway void sendGuidedPoint(in LatLong point, boolean force);

        /**
        * Set the altitude for the guided point.
        * @param altitude altitude in meters
        */
        oneway void setGuidedAltitude(double altitude);

        /**
        * Set the guided velocity.
        * @param xVel velocity in the north direction
        * @param yVel velocity in the east direction
        * @param zVel vertical velocity.
        */
        oneway void setGuidedVelocity(double xVel, double yVel, double zVel);

        /**
        * Enables follow-me if disabled.
        * @param followMode follow-me mode to use.
        */
        oneway void enableFollowMe(in FollowType followType);

        /**
        * Sets the follow-me radius.
        * @param radius radius in meters.
        */
        oneway void setFollowMeRadius(double radius);

        /**
        * Disables follow me is enabled.
        */
        oneway void disableFollowMe();

        /**
        * Enables drone-share upload for the data of the connected drone.
        */
        oneway void enableDroneShare(String username, String password, boolean isEnabled);

        oneway void triggerCamera();

        oneway void epmCommand(boolean release);

        oneway void loadWaypoints();
}
