/*
 * Copyright (C) 2021 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package android.hardware.gnss;

/**
 * The callback interface to report GNSS antenna information from the HAL.
 *
 * @hide
 */
@VintfStability
interface IGnssAntennaInfoCallback {
    /**
     * A row of doubles. This is used to represent a row in a 2D array, which are used to
     * characterize the phase center variation corrections and signal gain corrections.
     */
    @VintfStability
    parcelable Row {
        double[] row;
    }

    /**
     * A point in 3D space, with associated uncertainty.
     */
    @VintfStability
    parcelable Coord {
        double x;

        double xUncertainty;

        double y;

        double yUncertainty;

        double z;

        double zUncertainty;
    }

    @VintfStability
    parcelable GnssAntennaInfo {
        /**
         * The carrier frequency in Hz.
         */
        long carrierFrequencyHz;

        /**
         * Phase center offset (PCO) with associated 1-sigma uncertainty. PCO is defined with
         * respect to the origin of the Android sensor coordinate system, e.g., center of primary
         * screen for mobiles - see sensor or form factor documents for details.
         */
        Coord phaseCenterOffsetCoordinateMillimeters;

        /**
         * 2D vectors representing the phase center variation (PCV) corrections, in
         * millimeters, at regularly spaced azimuthal angle (theta) and zenith angle
         * (phi). The PCV correction is added to the phase measurement to obtain the
         * corrected value.
         *
         * The azimuthal angle, theta, is defined with respect to the X axis of the
         * Android sensor coordinate system, increasing toward the Y axis. The zenith
         * angle, phi, is defined with respect to the Z axis of the Android Sensor
         * coordinate system, increasing toward the X-Y plane.
         *
         * Each row vector (outer vectors) represents a fixed theta. The first row
         * corresponds to a theta angle of 0 degrees. The last row corresponds to a
         * theta angle of (360 - deltaTheta) degrees, where deltaTheta is the regular
         * spacing between azimuthal angles, i.e., deltaTheta = 360 / (number of rows).
         *
         * The columns (inner vectors) represent fixed zenith angles, beginning at 0
         * degrees and ending at 180 degrees. They are separated by deltaPhi, the regular
         * spacing between zenith angles, i.e., deltaPhi = 180 / (number of columns - 1).
         *
         * This field is optional, i.e., an empty vector.
         */
        Row[] phaseCenterVariationCorrectionMillimeters;

        /**
         * 2D vectors of 1-sigma uncertainty in millimeters associated with the PCV
         * correction values.
         *
         * This field is optional, i.e., an empty vector.
         */
        Row[] phaseCenterVariationCorrectionUncertaintyMillimeters;

        /**
         * 2D vectors representing the signal gain corrections at regularly spaced
         * azimuthal angle (theta) and zenith angle (phi). The values are calculated or
         * measured at the antenna feed point without considering the radio and receiver
         * noise figure and path loss contribution, in dBi, i.e., decibel over isotropic
         * antenna with the same total power. The signal gain correction is added the
         * signal gain measurement to obtain the corrected value.
         *
         * The azimuthal angle, theta, is defined with respect to the X axis of the
         * Android sensor coordinate system, increasing toward the Y axis. The zenith
         * angle, phi, is defined with respect to the Z axis of the Android Sensor
         * coordinate system, increasing toward the X-Y plane.
         *
         * Each row vector (outer vectors) represents a fixed theta. The first row
         * corresponds to a theta angle of 0 degrees. The last row corresponds to a
         * theta angle of (360 - deltaTheta) degrees, where deltaTheta is the regular
         * spacing between azimuthal angles, i.e., deltaTheta = 360 / (number of rows).
         *
         * The columns (inner vectors) represent fixed zenith angles, beginning at 0
         * degrees and ending at 180 degrees. They are separated by deltaPhi, the regular
         * spacing between zenith angles, i.e., deltaPhi = 180 / (number of columns - 1).
         *
         * This field is optional, i.e., an empty vector.
         */
        Row[] signalGainCorrectionDbi;

        /**
         * 2D vectors of 1-sigma uncertainty in dBi associated with the signal
         * gain correction values.
         *
         * This field is optional, i.e., an empty vector.
         */
        Row[] signalGainCorrectionUncertaintyDbi;
    }

    /**
     * Called when on connection, and on known-change to these values, such as upon a known
     * GNSS RF antenna tuning change, or a foldable device state change.
     *
     * This is optional. It can never be called if the GNSS antenna information is not
     * available.
     */
    void gnssAntennaInfoCb(in GnssAntennaInfo[] gnssAntennaInfos);
}
