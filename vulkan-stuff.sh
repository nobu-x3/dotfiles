
# vulkan stuff
curl -o vulkanSDK.tar.xz https://sdk.lunarg.com/sdk/download/1.3.268.0/linux/vulkansdk-linux-x86_64-1.3.268.0.tar.xz
tar -xf vulkanSDK.tar.xz
mv 1.3.268.0 ~/vulkanSDK
rm -rf vulkanSDK.tar.xz
exec ~/vulkanSDK/vulkansdk spirvtools loader headers tools shaderc vul vulkan-extensionlayer spirv-reflect spirv-cross vcv volk --maxjobs
