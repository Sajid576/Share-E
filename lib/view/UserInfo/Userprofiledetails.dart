class Userprofiledetails{
    var phone;
    var username;
    var uid;
    var session;
    var email;
    Userprofiledetails({this.phone,this.username,this.uid,this.session,this.email});
    getphone(){
      return phone;
    }

    getuid(){
      return uid;
    }

    getusername(){
      return username;
    }

    getsession(){
      return session;
    }
    getemail(){
      return email;
    }

}