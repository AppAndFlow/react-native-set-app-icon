declare const ChangeAppIcon: {
  getIconName(): Promise<string>;
  changeIcon(iconName: string): Promise<string>;
};

export default ChangeAppIcon;
