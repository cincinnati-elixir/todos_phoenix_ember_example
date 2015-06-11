import Ember from 'ember';

import {Socket} from '../phoenix';

export default Ember.Service.extend({

  socket: function(){
    return new Socket("/ws");
  },

  connect: function(channel, topic, initialPayload={}){
    let socket = this.socket();
    socket.connect();
    let chan = socket.chan(`${channel}:${topic}`, initialPayload);

    chan.join().receive("ok", data => {
      console.log("Success!");
    });
    return chan;
  }
});
