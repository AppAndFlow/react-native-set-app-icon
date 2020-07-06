# react-native-set-app-icon

Let your users dynamically change their app icons directly from within the app.

## ANDROID IN PROGRESS

## Getting started

`$ npm install react-native-set-app-icon --save`

### Mostly automatic installation

`$ react-native link react-native-set-app-icon`

## IOS

Setup XCode

Put all your images as `@2x.png` `@3x.png` in the root of your project setup.

![](docs/icons.png)

Once that's done, go to `Info.plist` and follow this setup : 

![](docs/infoplist.png)

## Usage

```javascript
import SetAppIcon from "react-native-set-app-icon";
```

### changeAppIcon

Promise that returns a boolean. Takes the `iconName` name set in your config.

```js
SetAppIcon.changeIcon(iconName: string): Promise<boolean>;
```

If you want to set the default back just use `null`.

```js
SetAppIcon.changeIcon(null);
```

### getIconName

Takes a callback and receives an object with `iconName` in it.

```js
SetAppIcon.getIconName(cb: (icon: { iconName: string }) => void): void;
```

### supportsDynamicAppIcon

Returns a Promise with a boolean if the device accepts the dynamic app icon change.

```js
SetAppIcon.supportsDynamicAppIcon(): Promise<boolean>;
```
