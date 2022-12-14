/*
 * Copyright (C) 2020 The Android Open Source Project
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

package android.hardware.automotive.audiocontrol;

import android.hardware.audio.common.PlaybackTrackMetadata;
import android.hardware.automotive.audiocontrol.AudioFocusChange;

/**
 * Callback interface for audio focus listener.
 *
 * For typical configuration, the listener the car audio service.
 *
 */
@VintfStability
interface IFocusListener {
    /**
     * Called whenever HAL is abandoning focus as it is finished playing audio of a given usage in a
     * specific zone.
     *
     * In response, IAudioControl#onAudioFocusChange will be called with focusChange status. This
     * interaction is oneway to avoid blocking HAL so that it is not required to wait for a response
     * before stopping audio playback.
     *
     * Deprecated in version 2 to allow generic interface callback listener.
     * Use {@link IFocusListener#abandonHalAudioFocusWithMetaData} instead.
     *
     * @param usage The audio usage for which the HAL is abandoning focus {@code AttributeUsage}.
     * See {@code audioUsage} in audio_policy_configuration.xsd for the list of allowed values.
     * @param zoneId The identifier for the audio zone that the HAL abandoning focus
     */
    oneway void abandonAudioFocus(in String usage, in int zoneId);

    /**
     * Called whenever HAL is requesting focus as it is starting to play audio of a given usage in a
     * specified zone.
     *
     * In response, IAudioControl#onAudioFocusChange will be called with focusChange status. This
     * interaction is oneway to avoid blocking HAL so that it is not required to wait for a response
     * before playing audio.
     *
     * Deprecated in version 2 to allow generic interface callback listener.
     * Use {@link IFocusListener#requestAudioFocusWithMetaData} instead.
     *
     * @param usage The audio usage associated with the focus request {@code AttributeUsage}. See
     * {@code audioUsage} in audio_policy_configuration.xsd for the list of allowed values.
     * @param zoneId The identifier for the audio zone where the HAL is requesting focus
     * @param focusGain The AudioFocusChange associated with this request. Should be one of the
     * following: GAIN, GAIN_TRANSIENT, GAIN_TRANSIENT_MAY_DUCK, GAIN_TRANSIENT_EXCLUSIVE.
     */
    oneway void requestAudioFocus(in String usage, in int zoneId, in AudioFocusChange focusGain);

    /**
     * Used to indicate that the audio output stream associated with
     * {@link android.hardware.audio.common.PlaybackTrackMetadata} has released
     * the focus.
     *
     * @param playbackMetaData The output stream metadata associated with the focus request
     * @param zoneId The identifier for the audio zone that the HAL abandoning focus
     */
    oneway void abandonAudioFocusWithMetaData(
            in PlaybackTrackMetadata playbackMetaData, in int zoneId);

    /**
     * Used to indicate that the audio output stream associated with
     * {@link android.hardware.audio.common.PlaybackTrackMetadata} has taken the focus.
     *
     * @param playbackMetaData The output stream metadata associated with the focus request
     * @param zoneId The identifier for the audio zone that the HAL abandoning focus
     * @param focusGain The focus type requested.
     *                  This must be one of the
     *                  {@link android.hardware.automotive.audiocontrol.AudioFocusChange}
     *                  constants.
     */
    oneway void requestAudioFocusWithMetaData(in PlaybackTrackMetadata playbackMetaData,
            in int zoneId, in AudioFocusChange focusGain);
}
