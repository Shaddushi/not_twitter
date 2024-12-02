<script setup>

    import { ref, onMounted } from 'vue';
    import axios from 'axios';
    const message = ref([]); 
    const user_name = ref();
    const user_description = ref();
    async function CreateNewUser( ) {
        try {
            await axios.post('http://localhost:8080/api/sendNewUsers',data);
        } catch (error) {
            console.error('Erreur lors de la récupération du message :', error);
        }
    }


</script>



<template>
    <div> Username : </div>
    <input v-model="user_name">
    <div> Username : </div>
    <input v-model="user_description">
  </template>
  

  