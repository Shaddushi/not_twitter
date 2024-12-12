<script setup>
    
    import { ref, onMounted, watch } from 'vue';
    import axios from 'axios';

    const user_name = ref();
    const user_mdp = ref();
    const incorrect_account = ref(false)
    const emit = defineEmits(['SendUsername'])
    const isModalOpen = ref(true)


    onMounted(() => {
        const myModal = new bootstrap.Modal('#Modal');
        myModal.show();
    })


    watch(user_mdp,() =>{
      if(incorrect_account.value){
        incorrect_account.value = !incorrect_account.value
      }
    })
    
    watch(user_name,() =>{
      if(incorrect_account.value){
        incorrect_account.value = !incorrect_account.value
      }
    })


    function CreateNewUser( ) {
        let data = JSON.stringify({"newusername":user_name.value, "newuser_mdp": user_mdp.value})
        axios.post('http://localhost:8080/api/submitNewUser',data).then((response) => {
            if(response.data.valid){
              const myModal = bootstrap.Modal.getInstance(document.getElementById('Modal'));
              if (myModal) {
                myModal.hide();
              }
              isModalOpen.value = false
              console.log(response.data.username)
              emit("SendUsername", response.data.username); 
            }
            else{
              incorrect_account.value = true
            }
            })
    }
</script>



<template v-if="isModalOpen">
  
  <div class="modal fade" id="Modal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true" data-bs-keyboard="false" data-bs-backdrop="static" >
    <div class="  bordere modal-dialog">
      <div class=" rounded-0 modal-content" style="display: flex; justify-content: center; align-items: center;">
        <div class=" borderbtm gradient rounded-0   modal-header" >
          <div class="h1 modal-title fs-5 title-font" id="ModalLabel" >
            Login
          </div>
        </div>
        <div class="gradient modal-body">
            <input v-model="user_name" :class="{ error : incorrect_account}" class="input" placeholder="Username" style="margin-top: 5%;">
            <div :class="{ incorrect : incorrect_account}">  </div>
            <input v-model="user_mdp" :class="{ error : incorrect_account}" class="input" placeholder="Password">
            <button @click="CreateNewUser" class="btn btn-dark" >Confirm</button>
        </div>
      </div>
    </div>
  </div>
    
</template>
  

  
<style>



.input
  {
    width: 100%;
    font-size: 1rem;
    padding: 0.25rem;
    vertical-align: middle;
    box-shadow: 0 0 0 transparent;
    border: 1px solid #999;
    outline: 0 none;
    transition: box-shadow 0.5s;
    margin-bottom: 5%;
  }

.error
  {
    animation: shake 0.2s ease-in-out 0s 2;
    box-shadow: 0 0 0.5em red;
  }

@keyframes shake {
  0% { margin-left: 0rem; }
  25% { margin-left: 0.5rem; }
  75% { margin-left: -0.5rem; }
  100% { margin-left: 0rem; }
}


</style>