<script setup>

    import { ref } from 'vue';
    import axios from 'axios';
    const user_name = ref();
    const user_description = ref();
    async function CreateNewUser( ) {
        let data = JSON.stringify({"user":user_name.value, "user_description": user_description.value})
        console.log(data)
        try {
            const res = await axios.post('http://localhost:8080/api/submitNewUser',data);
            console.log(res)
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
    <button @click="CreateNewUser"></button>
  </template>
  

  