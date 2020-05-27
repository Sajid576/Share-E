class Userprofiledetails{
    var phone;
    var username;
    var uid;
    var session;
    var email;
    var myChatList;
    var dp;

    Userprofiledetails({this.dp,this.phone,this.username,this.uid,this.session,this.email,this.myChatList});
    getMyChatList()
    {
      return myChatList;
    }
    getDP()
    {
        return dp;
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