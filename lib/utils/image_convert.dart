String convertToDirectLink(String googleDriveLink) {
  // Extract the file ID from the Google Drive link
  RegExp regExp = RegExp(r"/file/d/(.*?)/");
  String fileId = regExp.firstMatch(googleDriveLink)?.group(1) ?? '';

  // Construct the direct link
  String directLink = 'https://drive.google.com/uc?id=$fileId';

  return directLink;
}