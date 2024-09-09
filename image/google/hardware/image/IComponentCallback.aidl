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

import android.hardware.HardwareBuffer;
import android.hardware.graphics.common.PixelFormat;

/**
 * Interface for an image codec component callback mechanism.
 * Notifies the client that they must return a newly allocated or previously
 * allocated buffer that fits the specified parameters.
 */
@VintfStability
interface IComponentCallback {
    /**
     * Creates or fetches an existing linear buffer, which will be used as the
     * destination buffer during image encoding.
     *
     * @param size The length of the linear buffer to be returned.
     * @param srcId The unique AHardwareBuffer ID for the source buffer associated
     * with this encoding operation.
     * @return HardwareBuffer to be filled with encode output. The format of the
     * buffer must be BLOB.
     */
    HardwareBuffer allocateLinearBuffer(in int size, in int srcId);

    /**
     * Creates or fetches an existing graphic buffer, which will be used as the
     * destination buffer during image decoding.
     *
     * @param width The width of the graphic buffer to be returned.
     * @param height The height of the graphic buffer to be returned.
     * @param colorFormat The colour format of the image that this buffer will
     * be used for.
     * @param srcId The unique AHardwareBuffer ID for the source buffer associated
     * with this encoding operation.
     * @return HardwareBuffer to be filled with decode output. The format of the
     * buffer must be one of the supported colour formats from
     * IComponent::queryComponentConstraints.
     */
    HardwareBuffer allocateGraphicBuffer(
            in int width, in int height, in PixelFormat colorFormat, in int srcId);
}
