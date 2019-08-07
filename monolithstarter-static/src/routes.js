import HelloPage from './pages/HelloPage';
import HomePage from "./pages/HomePage";

const routes = [
  {path: '/', exact: true, name: 'Home', component: HomePage},
  {path: '/hello', exact: true, name: 'Hello', component: HelloPage}
];

export default routes;
