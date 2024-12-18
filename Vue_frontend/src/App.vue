<script setup>

  import ModelLogin from "./components/ModelLogin.vue";
  import { ref, onMounted } from 'vue';
  import NavBar from "./components/NavBar.vue";

  const currentUser = ref();
  const hasConnected = ref(false)

  const getUsername = ((data) =>{
    console.log(data)
    currentUser.value = data
    hasConnected.value = true
  })



</script>


<template>
  <div class="container" style="height: 100%;">
    <div class="row" style="height: 100%;">
      <div class="col-3 rounded border ">
        <NavBar :username="currentUser"></NavBar>
        
      </div>
      <div class="col-9">
        <RouterView></RouterView>
      </div>  
    </div>
  </div>



  <div v-if="!hasConnected">
      <ModelLogin  @SendUsername="getUsername" ></ModelLogin>
    </div>

</template>

