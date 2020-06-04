declare const ChangeAppicon: {
  getIconName(): Promise<{ iconName: string }>;
  changeIcon(iconName: string): Promise<boolean>;
};

export default ChangeAppicon;
