package cn.tikey.dao;

import cn.tikey.entity.Member;
import cn.tikey.helper.MemberState;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberRepository extends JpaRepository<Member, String> {
    Member findByEmail(String email);
    @Modifying
    @Query("update Member m set m.memberState = ?1 where m.email = ?2")
    int setMemberStateFor(MemberState memberState, String email);
}
