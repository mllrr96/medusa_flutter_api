class StorePostAuthReq {
  /// description: email address of the customer
  /// [TYPE]: [String]
  /// required
  String? email;

  /// description: password of the customer
  /// [TYPE]: [String]
  /// required
  String? password;

  StorePostAuthReq({
    this.email,
    this.password,
  });

  StorePostAuthReq.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
