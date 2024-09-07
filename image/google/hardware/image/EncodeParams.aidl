/******************************************************************************
 *
 *  Copyright (C) 2024 Google LLC.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at:
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 ******************************************************************************/
package google.hardware.image;

import google.hardware.image.Metadata;
import google.hardware.image.MirrorDirection;
import google.hardware.image.RotationDegree;

/**
 * Parameters required to encode an image.
 */
@VintfStability
parcelable EncodeParams {
    int picWidth;
    int picHeight;
    int qualityFactor;
    Metadata[] meta;
}