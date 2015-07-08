import DS from 'ember-data';
import Ember from 'ember';

export default DS.JSONAPIAdapter.extend({
  namespace: 'api',
  channelService: Ember.inject.service("channel"),
  channel: null,

  /* It would be awesome if we could make Phoenix serve up the correct content-type (application/vnd.api+json)
   * but I have no idea how to do that :) */
  headers: {
    Accept: 'application/json'
  },

  setupChannel: function(){
    this.set('channel', this.get('channelService').connect('todos','list', {}));

    this.channel.on("todo", todo => {
      console.log("Received updated TODO!");
      console.log(todo);
      this.get('store').push(todo);
    });

    this.channel.on("deleted_todo", todo => {
      console.log("Received deleted TODO!");
      console.log(todo);
      let record = this.get('store').getById('todo', todo.todo.id);
      if(record) {
        this.get('store').unloadRecord(record);
      }
    });

  }.on('init')
});
