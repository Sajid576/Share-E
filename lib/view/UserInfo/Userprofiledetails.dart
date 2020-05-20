class Userprofiledetails{
    var phone;
    var username;
    var uid;
    var session;
    var email;
    var myChatList;

    Userprofiledetails({this.phone,this.username,this.uid,this.session,this.email,this.myChatList});
    getMyChatList()
    {
      return myChatList;
    }
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