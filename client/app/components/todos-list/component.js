import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'ul',
  channel: Ember.inject.service(),
});
