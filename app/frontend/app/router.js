import EmberRouter from '@ember/routing/router';
import config from './config/environment';
import RouterScroll from 'ember-router-scroll';

const Router = EmberRouter.extend(RouterScroll, {
  location: config.locationType,
  rootURL:  config.rootURL
});

Router.map(function() {
  this.route('index', { path: '/' });
  this.route('asset', { path: '/assets/:id' });
  this.route('login');
  this.route('chooser');
});

export default Router;

