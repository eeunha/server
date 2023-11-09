<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/apa/main.do">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3 hansans"> 아파! 어디가? </div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0" >

    <!-- Nav Item - Dashboard -->
    <li class="nav-item">
        <a class="nav-link" href="/apa/hospital/diagnosis/list.do" style="">
            <i class="fas fa-fw fa-hospital-alt"></i>
            <span>병원 관리</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

	<!-- Nav Item - Utilities Collapse Menu -->
    <li class="nav-item active">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
            aria-expanded="true" aria-controls="collapseUtilities">
            <i class="fas fa-fw fa-stethoscope"></i>
            <span>진료</span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
            data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <a class="collapse-item" href="/apa/hospital/diagnosis/list.do">오늘의 진료</a>
                <a class="collapse-item" href="/apa/hospital/diagnosis/list.do">모든 진료 예약</a>
                <a class="collapse-item" href="/apa/hospital/diagnosis/total/list.do">모든 진료 내역</a>
            </div>
        </div>
    </li>

    <!-- Nav Item - Utilities Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
            aria-expanded="true" aria-controls="collapseUtilities">
            <i class="fas fa-fw fa-calendar-check"></i>
            <span>건강검진</span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
            data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <!-- <h6 class="collapse-header">건강검진 타입: </h6> -->
                <a class="collapse-item" href="#">오늘의 건강검진</a>
                <a class="collapse-item" href="/apa/hospital/chart/list.do">문진표</a>
                <a class="collapse-item" href="#">모든 건강검진 예약</a>
                <a class="collapse-item" href="#">모든 건강검진 내역</a>
            </div>
        </div>
    </li>
    
    <!-- Nav Item - Utilities Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
            aria-expanded="true" aria-controls="collapseUtilities">
            <i class="fas fa-fw fa-user"></i>
            <span>고객</span>
        </a>
        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
            data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <a class="collapse-item" href="/apa/hospital/customer/list.do">내원환자</a>
                <a class="collapse-item" href="/apa/hospital/document/list.do">서류요청</a>
            </div>
        </div>
    </li>
    
    <!-- Nav Item - Pages Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="/apa/hospital/advice/list.do">
            <i class="fas fa-fw fa-file-alt"></i>
            <span>의학상담</span>
        </a>
    </li>
    
    <!-- Nav Item - Pages Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="/apa/hospital/entry/list.do">
            <i class="fas fa-fw fa-heart"></i>
            <span>입점하기</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

</ul>
<!-- End of Sidebar -->