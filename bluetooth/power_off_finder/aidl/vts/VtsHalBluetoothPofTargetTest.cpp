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

#include <aidl/Gtest.h>
#include <aidl/Vintf.h>
#include <aidl/hardware/google/bluetooth/power_off_finder/IBluetoothFinder.h>
#include <android-base/logging.h>
#include <android/binder_manager.h>
#include <android/binder_process.h>
#include <binder/IServiceManager.h>
#include <utils/Log.h>

#include <vector>

using ::aidl::hardware::google::bluetooth::power_off_finder::IBluetoothFinder;
using ::ndk::ScopedAStatus;

class BluetoothPofTest : public ::testing::TestWithParam<std::string> {
public:
  virtual void SetUp() override;
  virtual void TearDown() override;

  // test functions to call
  ScopedAStatus sendAndCheckPrecomputedKeys(uint_t numKeys);
  ScopedAStatus checkStartPowerOffMode(uint8_t startIndex);

private:
  std::shared_ptr<IBluetoothFinder> bluetooth_pof;
};

void BluetoothPofTest::SetUp() {
  ALOGI("SetUp POF Test");
  bluetooth_pof = IBluetoothFinder::fromBinder(
      ndk::SpAIBinder(AServiceManager_waitForService(GetParam().c_str())));
  ASSERT_NE(bluetooth_pof, nullptr);
}

void BluetoothPofTest::TearDown() {
  ALOGI("TearDown POF Test");
  bluetooth_pof = nullptr;
  ASSERT_EQ(bluetooth_pof, nullptr);
}

ScopedAStatus BluetoothPofTest::sendAndCheckPrecomputedKeys(uint_t numKeys) {
  // creating mock keys
  std::vector<uint8_t> keys(20 * numKeys);
  for (uint_t i = 0; i < keys.size(); ++i)
    keys[i] = ((i / 20) + 1) & 0xff;
  // sending keys to the controller
  return bluetooth_pof->sendPrecomputedKeys(keys);
}

ScopedAStatus BluetoothPofTest::checkStartPowerOffMode(uint8_t startIndex) {
  return bluetooth_pof->startPoweredOffMode(startIndex);
}

TEST_P(BluetoothPofTest, SendAndCheckPrecomputedKeySingle) {
  ScopedAStatus status = sendAndCheckPrecomputedKeys(1);
  ASSERT_TRUE(status.isOk());
}

TEST_P(BluetoothPofTest, SendAndCheckPrecomputedKeyManyKeys) {
  ScopedAStatus status = sendAndCheckPrecomputedKeys(30);
  ASSERT_TRUE(status.isOk());
}

TEST_P(BluetoothPofTest, StartPowerOffMode) {
  ScopedAStatus status = checkStartPowerOffMode(0);
  ASSERT_TRUE(status.isOk());
}

GTEST_ALLOW_UNINSTANTIATED_PARAMETERIZED_TEST(BluetoothPofTest);
INSTANTIATE_TEST_SUITE_P(PerInstance, BluetoothPofTest,
                         testing::ValuesIn(android::getAidlHalInstanceNames(
                             IBluetoothFinder::descriptor)),
                         android::PrintInstanceNameToString);

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  ABinderProcess_startThreadPool();
  int status = RUN_ALL_TESTS();
  ALOGI("Test result = %d", status);
  return status;
}
