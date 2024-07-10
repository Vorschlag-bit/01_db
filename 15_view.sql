-- Drop existing tables if they exist

DROP TABLE IF EXISTS blacklist_history;
DROP TABLE IF EXISTS bookmark;
DROP TABLE IF EXISTS fiber_ptrn_info;
DROP TABLE IF EXISTS statistics;
DROP TABLE IF EXISTS file;
DROP TABLE IF EXISTS member_login_history;
DROP TABLE IF EXISTS member_history;
DROP TABLE IF EXISTS event_part_member;
DROP TABLE IF EXISTS ask;
DROP TABLE IF EXISTS report;
DROP TABLE IF EXISTS thread;
DROP TABLE IF EXISTS answer;
DROP TABLE IF EXISTS question_board;
DROP TABLE if EXISTS comment;
DROP TABLE IF EXISTS notice;
DROP TABLE IF EXISTS pattern_share;
DROP TABLE IF EXISTS board;
DROP TABLE IF EXISTS member;
SHOW TABLES;

CREATE TABLE IF NOT EXISTS thread
(
    no INTEGER NOT NULL AUTO_INCREMENT comment '실 ID',
    name VARCHAR(255) NOT NULL comment '실 이름',
    fiber VARCHAR(255) NOT NULL comment '실 재질',
    thick DECIMAL NOT NULL comment '실 두께',
    color VARCHAR(255) NOT NULL comment '실 색상',
    PRIMARY KEY (no)
)
comment = '실';


-- Create tables with proper foreign key constraints
CREATE TABLE IF NOT EXISTS member
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '회원 ID',
    id VARCHAR(255) NOT NULL COMMENT '아이디',
    pw VARCHAR(255) NOT NULL COMMENT '비밀번호',
    name VARCHAR(255) NOT NULL COMMENT '회원실명',
    nick VARCHAR(255) NOT NULL COMMENT '닉네임',
    phone VARCHAR(255) NOT NULL COMMENT '전화번호',
    email VARCHAR(255) NOT NULL COMMENT '이메일',
    grade VARCHAR(255) NOT NULL COMMENT '회원등급',
    gender CHAR(4) NOT NULL CHECK(gender IN ('M', 'F')),
    age INTEGER NOT NULL COMMENT '회원나이',
    black_check CHAR(4) DEFAULT 'N' NOT NULL CHECK(black_check IN ('Y', 'N')),
    auth_check CHAR(4) DEFAULT 'N' NOT NULL CHECK(auth_check IN ('Y', 'N')),
    PRIMARY KEY (no)
)
COMMENT = '회원';       

CREATE TABLE IF NOT EXISTS question_board
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '질문 게시글 ID',
    title VARCHAR(255) NOT NULL COMMENT '질문 제목',
    content MEDIUMTEXT NOT NULL COMMENT '질문 내용',
    reg_date DATETIME NOT NULL COMMENT '등록 날짜',
    edit_date DATETIME COMMENT '수정 날짜',
    view_count INTEGER DEFAULT 0 NOT NULL COMMENT '조회수',
    like_count INTEGER DEFAULT 0 NOT NULL COMMENT '좋아요 수',
    also_curious_count INTEGER DEFAULT 0 NOT NULL COMMENT '나도 궁금해요 수',
    answer_status CHAR(4) DEFAULT 'N' NOT NULL CHECK(answer_status IN ('Y', 'N')),
    mem_no INTEGER COMMENT '질문 작성자 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no)
)
COMMENT = '질문게시판';

CREATE TABLE IF NOT EXISTS answer
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '답변 ID',
    content MEDIUMTEXT NOT NULL COMMENT '답변 내용',
    like_count INTEGER DEFAULT 0 NOT NULL COMMENT '좋아요 수',
    sel_status CHAR(4) DEFAULT 'N' NOT NULL CHECK(sel_status IN ('Y', 'N')),
    ans_date DATETIME NOT NULL COMMENT '답변 작성 날짜',
    mem_no INTEGER NOT NULL COMMENT '답변 작성자 ID',
    ques_no INTEGER NOT NULL COMMENT '질문 게시글 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no),
    FOREIGN KEY (ques_no) REFERENCES question_board(no) ON DELETE CASCADE
)
COMMENT = '질문답변';

CREATE TABLE IF NOT EXISTS ask
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '문의 ID',
    content MEDIUMTEXT NOT NULL COMMENT '문의 내용',
    status CHAR(4) DEFAULT 'N' NOT NULL CHECK(status IN ('Y', 'N')),
    ask_date DATETIME NOT NULL COMMENT '문의 작성 날짜',
    reply MEDIUMTEXT COMMENT '문의 답변',
    mem_no INTEGER NOT NULL COMMENT '문의 회원 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no)
)
COMMENT = '문의';

CREATE TABLE IF NOT EXISTS blacklist_history
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '블랙리스트 ID',
    black_date DATETIME NOT NULL COMMENT '블랙 날짜',
    reason MEDIUMTEXT NOT NULL COMMENT '블랙 사유',
    count INTEGER DEFAULT 0 NOT NULL COMMENT '블랙 횟수',
    mem_no INTEGER NOT NULL COMMENT '블랙 회원 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no)
)
COMMENT = '블랙리스트 이력';

CREATE TABLE IF NOT EXISTS board
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '게시글 ID',
    title VARCHAR(255) NOT NULL COMMENT '게시글 제목',
    content MEDIUMTEXT NOT NULL COMMENT '게시글 내용',
    reg_date DATETIME NOT NULL COMMENT '게시글 등록 날짜',
    edit_date DATETIME COMMENT '게시글 수정 날짜',
    view_count INTEGER DEFAULT 0 NOT NULL COMMENT '조회수',
    like_count INTEGER DEFAULT 0 NOT NULL COMMENT '좋아요 수',
    cate VARCHAR(255) NOT NULL COMMENT '게시글 카테고리',
    share_area VARCHAR(255) COMMENT '나눔 지역(장소)',
    share_mat_cate VARCHAR(255) COMMENT '나눔 재료 카테고리',
    event_date DATETIME COMMENT '행사 날짜',
    event_area VARCHAR(255) COMMENT '행사 장소',
    event_purpose VARCHAR(255) COMMENT '행사 목적',
    event_max_mem INTEGER COMMENT '행사 설정 인원',
    gauge_size INTEGER COMMENT '게이지 사이즈',
    sts_row_info INTEGER COMMENT '코 * 단 정보',
    pattern_sts INTEGER COMMENT '도안 기준 코',
    mem_no INTEGER NOT NULL COMMENT '게시글 작성자 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no)
)
COMMENT = '게시글';




CREATE TABLE IF NOT EXISTS event_part_member
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '회원별행사 ID',
    mem_no INTEGER NOT NULL COMMENT '회원 ID',
    brd_no INTEGER NOT NULL COMMENT '행사 게시글 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no),
    FOREIGN KEY (brd_no) REFERENCES board(no) ON DELETE CASCADE
)
COMMENT = '회원참여행사';

CREATE TABLE IF NOT EXISTS pattern_share
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '도안 공유 게시글 ID',
    title VARCHAR(255) NOT NULL COMMENT '도안 공유 게시글 제목',
    review_level VARCHAR(255) NOT NULL COMMENT '도안 체감 난이도',
    writer_level VARCHAR(255) NOT NULL COMMENT '도안 작성자 난이도',
    review_count INTEGER DEFAULT 0 NOT NULL COMMENT '도안 난이도 참여수',
    knit_method VARCHAR(255) NOT NULL COMMENT '도안 뜨개 방법',
    knit_niddle_size INTEGER NOT NULL COMMENT '도안 뜨개 바늘 사이즈',
    content MEDIUMTEXT NOT NULL COMMENT '도안 공유 게시글 내용',
    reg_date DATETIME NOT NULL COMMENT '도안 공유 게시글 등록 날짜',
    edit_date DATETIME COMMENT '도안 공유 게시글 수정 날짜',
    view_count INTEGER DEFAULT 0 NOT NULL COMMENT '조회수',
    like_count INTEGER DEFAULT 0 NOT NULL COMMENT '좋아요 수',
    mem_no INTEGER NOT NULL COMMENT '도안 공유 작성자 ID',
    pattern_cate VARCHAR(255) NOT NULL COMMENT '도안 카테고리',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no)
)
COMMENT = '도안 공유 게시판';       
 



CREATE TABLE IF NOT EXISTS fiber_ptrn_info
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '실_게시판 ID',
    trd_no INTEGER NOT NULL COMMENT '실 ID',
    ptrn_shr_no INTEGER NOT NULL COMMENT '도안 공유 게시글 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (trd_no) REFERENCES thread(no) ON DELETE CASCADE,
    FOREIGN KEY (ptrn_shr_no) REFERENCES pattern_share(no) ON DELETE CASCADE
)
COMMENT = '실_도안정보';


CREATE TABLE IF NOT EXISTS member_history
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '회원 이력 ID',
    dml VARCHAR(255) NOT NULL COMMENT 'DML 구분',
    id VARCHAR(255) NOT NULL COMMENT '아이디',
    pw VARCHAR(255) NOT NULL COMMENT '비밀번호',
    name VARCHAR(255) NOT NULL COMMENT '회원실명',
    nick VARCHAR(255) NOT NULL COMMENT '닉네임',
    phone VARCHAR(255) NOT NULL COMMENT '전화번호',
    email VARCHAR(255) NOT NULL COMMENT '이메일',
    grade VARCHAR(255) NOT NULL COMMENT '회원등급',
    gender CHAR(4) NOT NULL CHECK(gender IN ('M', 'F')),
    age INTEGER NOT NULL COMMENT '회원나이',
    black_check CHAR(4) DEFAULT 'N' NOT NULL CHECK(black_check IN ('Y', 'N')),
    auth_check CHAR(4) DEFAULT 'N' NOT NULL CHECK(auth_check IN ('Y', 'N')),
    mem_no INTEGER NOT NULL COMMENT '회원 ID',
    edit_date DATETIME NOT NULL COMMENT '이력변경 날짜',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no)
)
COMMENT = '회원 이력';

CREATE TABLE IF NOT EXISTS member_login_history
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '회원 로그인 이력 ID',
    logion_date DATETIME NOT NULL COMMENT '로그인 날짜',
    ip VARCHAR(255) NOT NULL COMMENT '로그인 IP',
    mem_no INTEGER NOT NULL COMMENT '회원 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no)
)
COMMENT = '회원 로그인 이력';

CREATE TABLE IF NOT EXISTS notice
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '공지 ID',
    title VARCHAR(255) NOT NULL COMMENT '게시글 제목',
    content MEDIUMTEXT NOT NULL COMMENT '게시글 내용',
    reg_date DATETIME NOT NULL COMMENT '게시글 등록 날짜',
    edit_date DATETIME COMMENT '게시글 수정 날짜',
    view_count INTEGER DEFAULT 0 NOT NULL COMMENT '조회수',
    like_count INTEGER DEFAULT 0 NOT NULL COMMENT '좋아요 수',
    comment_check CHAR(4) DEFAULT 'N' NOT NULL CHECK(comment_check IN ('Y', 'N')),
    mem_no INTEGER NOT NULL COMMENT '공지 게시글 작성자 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no)
)
COMMENT = '공지게시판';



CREATE TABLE IF NOT EXISTS comment
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '댓글 ID',
    content MEDIUMTEXT NOT NULL COMMENT '댓글 내용',
    reg_date DATETIME NOT NULL COMMENT '댓글 등록 날짜',
    brd_no INTEGER COMMENT '게시글 ID',
    notice_no INTEGER COMMENT '공지 ID',
    ptrn_shr_no INTEGER COMMENT '도안 공유 게시글 ID',
    mem_no INTEGER NOT NULL COMMENT '댓글 작성자 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (brd_no) REFERENCES board(no) ON DELETE CASCADE,
    FOREIGN KEY (notice_no) REFERENCES notice(no) ON DELETE CASCADE,
    FOREIGN KEY (ptrn_shr_no) REFERENCES pattern_share(no) ON DELETE CASCADE,
    FOREIGN KEY (mem_no) REFERENCES member(no)
)
COMMENT = '댓글';

CREATE TABLE IF NOT EXISTS report
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '신고 ID',
    content MEDIUMTEXT NOT NULL COMMENT '신고 문의 내용',
    status CHAR(4) DEFAULT 'N' NOT NULL CHECK(status IN ('Y', 'N')),
    rpt_date DATETIME NOT NULL COMMENT '신고 날짜',
    cmt_no INTEGER COMMENT '신고 받은 댓글 ID',
    cate VARCHAR(255) NOT NULL COMMENT '신고 카테고리',
    brd_no INTEGER COMMENT '신고받은 게시글 ID',
    mem_no INTEGER NOT NULL COMMENT '신고 접수자 ID',
    ques_no INTEGER COMMENT '질문 게시글 ID',
    ptrn_shr_no INTEGER COMMENT '도안 공유 게시글 ID',
    ans_no INTEGER COMMENT '질문답변 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (brd_no) REFERENCES board(no),
    FOREIGN KEY (mem_no) REFERENCES member(no),
    FOREIGN KEY (ques_no) REFERENCES question_board(no),
    FOREIGN KEY (ptrn_shr_no) REFERENCES pattern_share(no),
    FOREIGN KEY (ans_no) REFERENCES answer(no) ON DELETE CASCADE
)
COMMENT = '신고';

CREATE TABLE IF NOT EXISTS statistics
(
    no DATETIME NOT NULL COMMENT '통계',
    visitor_count INTEGER DEFAULT 0 NOT NULL COMMENT '누적 방문자 수',
    mat_count INTEGER DEFAULT 0 NOT NULL COMMENT '누적 재료 나눔 수',
    ptrn_count INTEGER DEFAULT 0 NOT NULL COMMENT '누적 도안공유 수',
    PRIMARY KEY (no)
)
COMMENT = '통계';



CREATE TABLE IF NOT EXISTS bookmark
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '북마크 ID',
    mem_no INTEGER NOT NULL COMMENT '회원 ID',
    brd_no INTEGER COMMENT '게시글 ID',
    ptrn_shr_no INTEGER COMMENT '도안 공유 게시글 ID',
    ques_no INTEGER COMMENT '질문 게시글 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (mem_no) REFERENCES member(no),
    FOREIGN KEY (brd_no) REFERENCES board(no) ON DELETE CASCADE,
    FOREIGN KEY (ptrn_shr_no) REFERENCES pattern_share(no) ON DELETE CASCADE,
    FOREIGN KEY (ques_no) REFERENCES question_board(no) ON DELETE CASCADE
)
comment = '북마크';


CREATE TABLE IF NOT EXISTS file
(
    no INTEGER NOT NULL AUTO_INCREMENT COMMENT '파일 ID',
    size VARCHAR(255) NOT NULL COMMENT '파일 크기',
    extension VARCHAR(255) NOT NULL COMMENT '파일 확장자',
    name VARCHAR(255) NOT NULL COMMENT '파일 이름',
    url VARCHAR(255) NOT NULL COMMENT '파일 URL',
    brd_no INTEGER COMMENT '게시글 ID',
    ask_no INTEGER COMMENT '문의 ID',
    ans_no INTEGER COMMENT '답변 ID',
    rpt_no INTEGER COMMENT '신고 ID',
    noti_no INTEGER COMMENT '공지 ID',
    ptrn_shr_no INTEGER COMMENT '도안 공유 게시글 ID',
    ques_no INTEGER COMMENT '질문 게시글 ID',
    PRIMARY KEY (no),
    FOREIGN KEY (brd_no) REFERENCES board(no) ON DELETE CASCADE,
    FOREIGN KEY (ask_no) REFERENCES ask(no) ON DELETE CASCADE,
    FOREIGN KEY (ans_no) REFERENCES answer(no) ON DELETE CASCADE,
    FOREIGN KEY (rpt_no) REFERENCES report(no),ask
    FOREIGN KEY (noti_no) REFERENCES notice(no) ON DELETE CASCADE,
    FOREIGN KEY (ptrn_shr_no) REFERENCES pattern_share(no) ON DELETE CASCADE,
    FOREIGN KEY (ques_no) REFERENCES question_board(no) ON DELETE CASCADE
)
COMMENT = '파일';