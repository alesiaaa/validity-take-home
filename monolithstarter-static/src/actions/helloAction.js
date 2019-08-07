import axios from 'axios';
import Utility from '../components/utils/Utility';

export async function getHelloMessage() {
  return (await axios.get(`${Utility.getDynamicPath()}/api/hello`)).data;
}
