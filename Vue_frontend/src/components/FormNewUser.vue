<script setup>

    import { ref } from 'vue';
    import axios from 'axios';
    const user_name = ref();
    const user_mdp = ref();
    function CreateNewUser( ) {
        let data = JSON.stringify({"newusername":user_name.value, "newuser_mdp": user_mdp.value})
        axios.post('http://localhost:8080/api/submitNewUser',data).then((response) => {
            console.log(response.data)
        })
    }
</script>



<template>
    <div> Username : </div>
    <input v-model="user_name">
    <div> password : </div>
    <input v-model="user_mdp">
    <button @click="CreateNewUser"></button>
  </template>
  

  