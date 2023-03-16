/*
 * Copyright 2023 The Android Open Source Project
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

package hardware.google.bluetooth.ccc;

/**
 * LMP event id to be monitored
 * CONNECT_IND indicator for initiating connection, timestamp will be at the anchor point
 * LL_PHY_UPDATE_IND indicator for PHY update
 */
@VintfStability
@Backing(type="byte")
enum LmpEventId {
    CONNECT_IND = 0x00,
    LL_PHY_UPDATE_IND = 0x01,
}