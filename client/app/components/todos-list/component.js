import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'ul',
  channel: Ember.inject.service(),
  chan: null,

  setupChannel: function(){
    this.set('chan', this.get('channel').connect());

    this.chan.on("todo", todo => {
      console.log("Received updated TODO!");
      console.log(todo);
      this.get('store').push('todo', todo.todo);
    });

    this.chan.on("deleted_todo", todo => {
      console.log("Received deleted TODO!");
      console.log(todo);
      this.get('store').find('todo', todo.todo.id).then(function(todo) {
        todo.deleteRecord();
      });
    });

  }.on('init')
});
