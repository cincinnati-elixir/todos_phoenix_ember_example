import Ember from 'ember';

import {Socket} from '../phoenix';

export default Ember.Service.extend({

  socket: function(){
    return new Socket("/ws");
  },

  connect: function(){
    var socket = this.socket();
    socket.connect();
    var chan = socket.chan("todos:list", {});

    chan.join().receive("ok", data => {
      console.log("Success!");
    });
    return chan;
  }
});
