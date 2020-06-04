declare const SetAppIcon: {
  getIconName(): Promise<{ iconName: string }>;
  changeIcon(iconName: string): Promise<boolean>;
  supportsDynamicAppIcon(): Promise<boolean>;
};

export default SetAppIcon;
