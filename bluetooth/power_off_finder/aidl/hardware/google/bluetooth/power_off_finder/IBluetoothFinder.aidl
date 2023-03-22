/*
 * Copyright 2022 The Android Open Source Project
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

package hardware.google.bluetooth.power_off_finder;

@VintfStability
interface IBluetoothFinder {
   /**
    * API to set the precomputed keys to the Bluetooth Controller
    *
    * @param keys Precomputed keys to the Bluetooth Controller
    */
    void sendPrecomputedKeys(in byte[] keys);

   /**
    * API to enable powered off feature
    *
    * @param enable true to enable; false to disable
    */
    void setPoweredOffMode(in boolean enable);
}
