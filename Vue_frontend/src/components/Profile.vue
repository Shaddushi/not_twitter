<script setup>
    import {ref,computed, onMounted} from 'vue'
    import { useRoute } from 'vue-router';
    import axios from 'axios';
    const route = useRoute()
    const currentProfileName = computed(() => route.params.profileName)
    const username = ref()
    const pseudo = ref()
    const description = ref()
    const incorrect_account = ref(false)

    ////////////////////////////////////////////////////////////////////////////////////////////


    onMounted(() =>{
        GetUser()
    })

    //////////////////////////////////////////////////////////////////////////////////////////////

    function GetUser(){
        let data = JSON.stringify(currentProfileName.value)
        axios.post('http://localhost:8080/api/GetUser',data).then((response) => {
            if(response.data.valid){
              username.value = response.data.username
              pseudo.value = response.data.pseudo
              description.value = response.data.description
            }
            else{
              incorrect_account.value = true
            }
            }).catch((error)=>{
              console.log(error)
            })
    }



</script>

<template>

{{ description }}

    
</template>