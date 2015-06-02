import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'ul',
  channel: Ember.inject.service(),

  didInsertElement: function(){
    var socket = this.get('channel').socket();
    socket.connect();
    var chan = socket.chan("todos:list", {});
    chan.join().receive("ok", chan => {
      console.log("Success!");
    });
  }
});
