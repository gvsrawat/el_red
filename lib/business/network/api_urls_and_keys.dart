///authorized user token and other secret keys
abstract class ElToken {
  static const String apiToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiclhnY1Y2YXh3eVRobTNQdE04aGtSaXJTQ2ZsMiIsImlhdCI6MTY5NTc4NTYwNCwiZXhwIjoxNjk3MDgxNjA0fQ.x78m22QIE2w6NyIIzDVb31nWNCPWIkB5rEiOEmy-MSE";
  static const String cardId = "6300ba8b5c4ce60057ef9b0c";
}

///api urls
abstract class ElUrls {
  static const String fileUploadUrl =
      "https://dev.elred.io/postProfileBannerImage";
  static const String fetchInfoUrl =
      "https://dev.elred.io/selectedCardDesignDetails";
}
