<script setup>
    import { RouterLink } from 'vue-router';
    const props = defineProps({
        username: {
            String
        }
    })


</script>

<template>
    <div class="main-nav-div">
        <RouterLink  to="/home">Home</RouterLink>
        <RouterLink   :to="{ name: 'profile', params: { profileName: username } }" style="bottom: 0;">{{ username }}</RouterLink>
        
    </div>

</template>



<style>

    .main-nav-div{
        display: flex;
        flex-direction: column;
        align-items: center;
        padding-top: 10%;
        height: 100%;
    }





</style>