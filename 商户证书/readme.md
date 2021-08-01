# 生成自签名证书 

## 一、生成私钥 

```
openssl genrsa -des3 -out rootCA.key 2048

```
输入两次密码123456，在当前目录生成 rootCA.key


## 二、生成CSR

```
openssl req -new -key rootCA.key -out my.csr
```

需要依次输入国家，地区，城市，组织，组织单位，名字，Email等信息

## 删除私钥中的密码

以免启动时要求输入密码：
```
cp rootCA.key rootCA.key.org
openssl rsa -in rootCA.key.org -out rootCA.key
输入密码123456
```

## 四、生成自签名证书
```
openssl x509 -req -days 2650 -in my.csr -signkey rootCA.key -out my.crt
```

目录里生成证书文件 my.crt

## 生成公私钥文件

```
openssl req -x509 -nodes -days 730 -newkey rsa:2048 -keyout private.key -out public.pem
```

 或者 
 ```
$ openssl genrsa -out private.pem 2048
 
$ openssl rsa -in private.pem -pubout -out public.pem
```