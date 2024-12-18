import { createRouter, createWebHistory } from 'vue-router'
import App from '../App.vue'
import Profile from '../components/ProfileComponents/Profile.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/home',
      name: 'home',
      component: App,
    },
    {
      path: '/:profileName?',
      name: 'profile',
      component: Profile,
    },
    
  ],
})

export default router
