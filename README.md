# pod install runs into errors on MacOS big sur M1
- FFI stands for “Foreign Function Interface”. 
- It's a way to use functions defined in other programming languages. 
- Ruby's FFI module gives you access to external libraries & code that you wouldn't have otherwise.

- Install ffi
sudo arch -x86_64 gem install ffi
- And run pod install like this:
arch -x86_64 pod install instead of pod install.
- Tried with Alamofire : it works !

[running-cocoapods-on-apple-silicon-m1](https://stackoverflow.com/questions/64901180/running-cocoapods-on-apple-silicon-m1)



