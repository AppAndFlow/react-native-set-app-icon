declare const ChangeAppicon: {
  getIconName(): Promise<string>;
  changeIcon(iconName: string): Promise<string>;
};

export default ChangeAppicon;
