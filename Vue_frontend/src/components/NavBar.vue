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
        <h2 style="color: #AAA1C8;"> Y</h2>

        <RouterLink  to="/home">Home</RouterLink>
        <RouterLink   :to="{ name: 'profile', params: { profileName: username } }" class="mt-auto" style="margin-bottom: 15%;" >{{ username }}</RouterLink>
        
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