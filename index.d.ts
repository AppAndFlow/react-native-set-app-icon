declare const SetAppIcon: {
  getIconName(cb: (icon: { iconName: string }) => void): void;
  changeIcon(iconName: string | null): Promise<boolean>;
  supportsDynamicAppIcon(): Promise<boolean>;
};

export default SetAppIcon;
