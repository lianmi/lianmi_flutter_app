# linkme_flutter_sdk

## Getting Started
生成moor代码 
```
flutter pub run build_runner build --delete-conflicting-outputs
```

## Json生成model
```
https://app.quicktype.io/
```

{
    "private_key" : "",
    "public_key" : ""
}

#  More than one file was found with OS independent path ‘lib/x86/libc++_shared.so‘ 解决方法

https://blog.csdn.net/github_37673306/article/details/103804274

在android/app目录的下的build.gradle文件的android{}中添加这样一行代码
```
packagingOptions {
        pickFirst 'lib/x86/libc++_shared.so'
        pickFirst 'lib/arm64-v8a/libc++_shared.so'
        pickFirst 'lib/armeabi-v7a/libc++_shared.so'
        pickFirst 'lib/x86_64/libc++_shared.so'
}
```    
