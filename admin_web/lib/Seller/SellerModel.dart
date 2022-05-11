class Seller {
  Seller(
      {this.approved,
      this.storeName,
      this.storeImage,
      this.ownerName,
      this.address,
      this.contactNumber,
      this.emailAddress,
      this.registrationtype,
      this.uid});

  Seller.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          storeName: json['storeName']! as String,
          storeImage: json['storeImage']! as String,
          ownerName: json['ownerName']! as String,
          address: json['address']! as String,
          contactNumber: json['contactNumber']! as String,
          emailAddress: json['emailAddress']! as String,
          registrationtype: json['registrationtype']! as String,
          uid: json['uid']! as String,
        );

  final bool? approved;
  final String? storeName;
  final String? storeImage;
  final String? ownerName;
  final String? address;
  final String? contactNumber;
  final String? emailAddress;
  final String? registrationtype;
  final String? uid;

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'storeName': storeName,
      'storeImage': storeImage,
      'ownerName': ownerName,
      'address': address,
      'contactNumber': contactNumber,
      'emailAddress': emailAddress,
      'registrationtype': registrationtype,
      'uid': uid
    };
  }
}
