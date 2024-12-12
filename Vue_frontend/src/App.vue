<script setup>
  import PersonList from "./components/PersonList.vue"
  import ModelLogin from "./components/ModelLogin.vue";
  import { ref, onMounted } from 'vue';
  import axios from 'axios';
  const message = ref([]); 
  const currentUser = ref();
  const hasConnected = ref(false)
  onMounted(() => {
      axios.get('http://localhost:8080/api/getUsers').then((response) => {
        message.value = response.data.users; 
      }).catch(error => {
        message.value = 'Erreur lors de la connexion au serveur.';
      });
  });

  const SendUsernamefunc = ((data) =>{
    console.log(data)
    currentUser.value = data
    hasConnected.value = true
  })






</script>


<template>
  <div>
    
    <PersonList :users=message />
    
  </div>

  <div v-if="!hasConnected">
      <ModelLogin  @SendUsername="SendUsernamefunc" ></ModelLogin>
    </div>
</template>

