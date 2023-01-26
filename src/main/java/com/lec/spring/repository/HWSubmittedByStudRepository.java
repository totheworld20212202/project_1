package com.lec.spring.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.lec.spring.domain.HWSubmittedByStud;

public interface HWSubmittedByStudRepository extends JpaRepository<HWSubmittedByStud, Long> {

}
