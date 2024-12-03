<script setup>
  import PersonList from "./components/PersonList.vue"
  import FormNewUser from "./components/FormNewUser.vue";
  import { ref, onMounted } from 'vue';
  import axios from 'axios';
  const message = ref([]); 
  onMounted(async () => {
    try {
      const response = await axios.get('http://localhost:8080/api/getUsers');
      message.value = response.data.users; 
      console.log(message.value)

    } catch (error) {
      console.error('Erreur lors de la récupération du message :', error);
      message.value = 'Erreur lors de la connexion au serveur.';
    }

  });
</script>


<template>
  <div>
    <PersonList :users=message />
    <FormNewUser></FormNewUser>
  </div>
</template>

